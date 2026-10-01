# 2026-09-28T11:21:05.673635400
import vitis

client = vitis.create_client()
client.set_workspace(path="project_10")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../design_1_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

status = client.add_platform_repos(platform=["c:\Users\anton\project_10\platform"])

comp = client.create_app_component(name="app_component",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_ps7_cortexa9_0")

vitis.dispose()

