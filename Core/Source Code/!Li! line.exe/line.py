import math, sys

def dist(xs, ys):
    return math.sqrt(sum((x - y) ** 2 for x, y in zip(xs, ys)))

def get_heading(xy_a,xy_b):
    x,y = xy_b[0]-xy_a[0], xy_b[1]-xy_a[1]
    return (math.atan2(x,y)*180/math.pi) % 360

def get_unit_vector(heading):
    r = math.radians(heading)
    return math.sin(r), math.cos(r)


start = (int(sys.argv[1]),int(sys.argv[2]))

end = (int(sys.argv[3]),int(sys.argv[4]))


unit_vector = get_unit_vector(get_heading(start,end))
dist = dist(start, end)
points = []
for i in range(int(dist)):
    new_point = int(start[0]+(unit_vector[0]*i)), int(start[1]+(unit_vector[1]*i))
    if new_point not in points:
        points.append(new_point)

for point in points:
    print(f"{point[0]},{point[1]}")
print(f"{int(sys.argv[3])},{int(sys.argv[4])}")