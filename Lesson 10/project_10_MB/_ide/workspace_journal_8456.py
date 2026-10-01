# 2026-10-01T10:01:40.255060500
import vitis

client = vitis.create_client()
client.set_workspace(path="project_10_MB")

client.delete_component(name="app_component")

client.delete_component(name="componentName")

platform = client.get_component(name="platform")
domain = platform.add_domain(cpu = "microblaze_0",os = "standalone",name = "standalone_microblaze_1",display_name = "standalone_microblaze_1",support_app = "hello_world",generate_dtb = False)

comp = client.create_app_component(name="app_component",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_microblaze_0")

status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

