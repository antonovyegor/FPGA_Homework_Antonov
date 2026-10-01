#include "xparameters.h"
#include "xgpio.h"
#include "xtmrctr.h"

// Константи адрес з вашого xparameters.h
#define LED_BASEADDR XPAR_XGPIO_0_BASEADDR
#define BTN_BASEADDR XPAR_XGPIO_1_BASEADDR
#define SW_BASEADDR  XPAR_XGPIO_2_BASEADDR
#define TMR_BASEADDR XPAR_XTMRCTR_0_BASEADDR

#define TMRCTR_NUM 0
#define BASE_TICKS 50000000  // 1 секунда (Таймер працює на 50 МГц)
#define SPEED_STEP 10000000  // Крок зміни швидкості (0.2 с)
#define MIN_TICKS  5000000   // Максимальна швидкість (0.1 с, щоб не блимало занадто швидко)

XGpio led_gpio, btn_gpio, sw_gpio;
XTmrCtr timer;

int main() {
    XGpio_Config *gpio_cfg;
    XTmrCtr_Config *tmr_cfg;

    // --- 1. Ініціалізація GPIO ---
    gpio_cfg = XGpio_LookupConfig(LED_BASEADDR);
    XGpio_CfgInitialize(&led_gpio, gpio_cfg, gpio_cfg->BaseAddress);
    XGpio_SetDataDirection(&led_gpio, 1, 0x0); // Вихід

    gpio_cfg = XGpio_LookupConfig(BTN_BASEADDR);
    XGpio_CfgInitialize(&btn_gpio, gpio_cfg, gpio_cfg->BaseAddress);
    XGpio_SetDataDirection(&btn_gpio, 1, 0xF); // Вхід

    gpio_cfg = XGpio_LookupConfig(SW_BASEADDR);
    XGpio_CfgInitialize(&sw_gpio, gpio_cfg, gpio_cfg->BaseAddress);
    XGpio_SetDataDirection(&sw_gpio, 1, 0xF); // Вхід

    // --- 2. Ініціалізація Таймера ---
    tmr_cfg = XTmrCtr_LookupConfig(TMR_BASEADDR);
    XTmrCtr_CfgInitialize(&timer, tmr_cfg, tmr_cfg->BaseAddress);

    // Автоперезавантаження та зворотний відлік. (Переривання не вмикаємо)
    XTmrCtr_SetOptions(&timer, TMRCTR_NUM, XTC_AUTO_RELOAD_OPTION | XTC_DOWN_COUNT_OPTION);

    u32 current_ticks = BASE_TICKS;
    XTmrCtr_SetResetValue(&timer, TMRCTR_NUM, current_ticks);
    XTmrCtr_Start(&timer, TMRCTR_NUM);

    // --- 3. Початкові змінні ---
    u8 led_state = 0x01;
    XGpio_DiscreteWrite(&led_gpio, 1, led_state);
    
    u32 prev_btn = 0;
    u8 is_running = 1; // Прапорець руху (1 - працює, 0 - пауза)

    while (1) {
        // --- ОБРОБКА КНОПОК ---
        u32 btn_val = XGpio_DiscreteRead(&btn_gpio, 1);
        
        if (btn_val != prev_btn) {
            if (btn_val & 0x01) { 
                // BTN0: Збільшити швидкість (зменшити тайти)
                if (current_ticks > MIN_TICKS + SPEED_STEP) current_ticks -= SPEED_STEP;
                XTmrCtr_SetResetValue(&timer, TMRCTR_NUM, current_ticks);
            } 
            else if (btn_val & 0x02) { 
                // BTN1: Зменшити швидкість (збільшити такти)
                current_ticks += SPEED_STEP;
                XTmrCtr_SetResetValue(&timer, TMRCTR_NUM, current_ticks);
            } 
            else if (btn_val & 0x04) { 
                // BTN2: Зупинити рух
                is_running = 0;
            } 
            else if (btn_val & 0x08) { 
                // BTN3: Поновити рух
                is_running = 1;
                // Синхронізуємо таймер, щоб рух почався одразу, а не чекав старого відліку
                XTmrCtr_Reset(&timer, TMRCTR_NUM); 
            }
            prev_btn = btn_val;
        }

        // --- ОБРОБКА "БІЖУЧОЇ ДОРІЖКИ" ЧЕРЕЗ ТАЙМЕР ---
        // Перевіряємо апаратний прапорець завершення відліку таймера
        if (is_running && XTmrCtr_IsExpired(&timer, TMRCTR_NUM)) {
            
            // 1. Очищуємо прапорець, щоб таймер міг зафіксувати наступний цикл
            u32 csr = XTmrCtr_ReadReg(timer.BaseAddress, TMRCTR_NUM, XTC_TCSR_OFFSET);
            XTmrCtr_WriteReg(timer.BaseAddress, TMRCTR_NUM, XTC_TCSR_OFFSET, csr | XTC_CSR_INT_OCCURED_MASK);

            // 2. Читаємо стан перемикача для напрямку
            u32 sw_val = XGpio_DiscreteRead(&sw_gpio, 1);
            
            // 3. Зсуваємо світлодіоди
            if (sw_val & 0x01) { 
                // Рух Вперед (SW0 увімкнено)
                led_state = (led_state << 1);
                if (led_state > 0x08) led_state = 0x01; 
            } else {
                // Рух Назад (SW0 вимкнено)
                led_state = (led_state >> 1);
                if (led_state == 0x00) led_state = 0x08; 
            }

            // 4. Оновлюємо стан LED
            XGpio_DiscreteWrite(&led_gpio, 1, led_state);
        }
    }

    return 0;
}