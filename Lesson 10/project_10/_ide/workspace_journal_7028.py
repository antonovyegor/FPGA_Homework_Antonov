# 2026-09-28T17:35:55.041972500
import vitis

client = vitis.create_client()
client.set_workspace(path="project_10")

comp = client.get_component(name="app_component")
comp.build()

vitis.dispose()

