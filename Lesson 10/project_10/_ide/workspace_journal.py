# 2026-10-01T11:29:57.462900800
import vitis

client = vitis.create_client()
client.set_workspace(path="project_10")

comp = client.get_component(name="app_component")
comp.build()

platform = client.get_component(name="platform")
status = platform.build()

comp.build()

vitis.dispose()

