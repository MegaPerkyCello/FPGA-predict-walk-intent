# 2026-07-23T09:38:01.335386600
import vitis

client = vitis.create_client()
client.set_workspace(path="workspace")

comp = client.get_component(name="conv1")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

vitis.dispose()

