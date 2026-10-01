# 2026-09-28T12:09:22.024877100
import vitis

client = vitis.create_client()
client.set_workspace(path="project_10")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

comp.build()

comp.build()

comp.build()

