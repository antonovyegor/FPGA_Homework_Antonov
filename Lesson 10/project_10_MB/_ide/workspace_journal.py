# 2026-10-01T11:32:15.836501
import vitis

client = vitis.create_client()
client.set_workspace(path="project_10_MB")

platform = client.get_component(name="platform")
status = platform.build()

status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

vitis.dispose()

