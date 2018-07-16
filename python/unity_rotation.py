import math

# reference: https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles
def convert_euler_to_quaternion(pitch, yaw, roll):
    # pitch
    sp = math.sin(math.radians(pitch) * 0.5)
    cp = math.cos(math.radians(pitch) * 0.5)
    # yaw
    sy = math.sin(math.radians(yaw) * 0.5)
    cy = math.cos(math.radians(yaw) * 0.5)
    # roll
    sr = math.sin(math.radians(roll) * 0.5)
    cr = math.cos(math.radians(roll) * 0.5)

    qw = cy * cr * cp + sy * sr * sp;
    qx = cy * sr * cp - sy * cr * sp;
    qy = cy * cr * sp + sy * sr * cp;
    qz = sy * cr * cp - cy * sr * sp;
    return qw, qx, qy, qz