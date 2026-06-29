import open3d as o3d

o3d.utility.set_verbosity_level(o3d.utility.VerbosityLevel.Debug)

pcd = o3d.io.read_point_cloud("vis_pointcloud/demo10.ply")

print(pcd)

o3d.visualization.draw_geometries([pcd])

print("Finished")