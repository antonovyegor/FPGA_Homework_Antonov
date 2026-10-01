# 2026-09-30T22:38:19.871297200
import vitis

client = vitis.create_client()
client.set_workspace(path="project_10_MB")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../design_1_wrapper_MB.xsa",os = "standalone",cpu = "microblaze_0",domain_name = "standalone_microblaze_0",compiler = "gcc")

comp = client.create_app_component(name="app_component",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_microblaze_0")

platform = client.get_component(name="platform")
status = platform.build()

status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

status = platform.build()

status = platform.build()

comp.build()

comp = client.get_component(name="app_component")
comp.set_app_config(key = "USER_LINKER_SCRIPT", values = ["C:\Users\anton\project_10_MB\app_component\src\lscript.ld"])

status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../design_1_wrapper_MB.xsa")

status = platform.build()

status = comp.clean()

status = platform.build()

comp.build()

vitis.dispose()

