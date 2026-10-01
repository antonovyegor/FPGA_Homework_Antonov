# 2026-10-01T10:14:35.962166500
import vitis

client = vitis.create_client()
client.set_workspace(path="project_10_MB")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

comp = client.get_component(name="app_component")
comp.set_app_config(key = "USER_COMPILE_SOURCES", values = ["main.c", "../main.c", "C:/Users/anton/project_10_MB/app_component/src/main.c"])

status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

vitis.dispose()

