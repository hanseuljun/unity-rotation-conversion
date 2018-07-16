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
    #qx = cy * sr * cp - sy * cr * sp;
    #qy = cy * cr * sp + sy * sr * cp;
    #qz = sy * cr * cp - cy * sr * sp;
    # The order is different from the reference and maybe that's because
    # Unity is based on a left-handed coordinate system?
    qz = cy * sr * cp - sy * cr * sp;
    qx = cy * cr * sp + sy * sr * cp;
    qy = sy * cr * cp - cy * sr * sp;
    return qw, qx, qy, qz

def multiply_quaternions(qw1, qx1, qy1, qz1, qw2, qx2, qy2, qz2):
    w = qw1 * qw2 - qx1 * qx2 - qy1 * qy2 - qz1 * qz2
    x = qw1 * qx2 + qx1 * qw2 + qy1 * qz2 - qz1 * qy2
    y = qw1 * qy2 - qx1 * qz2 + qy1 * qw2 + qz1 * qx2
    z = qw1 * qz2 + qx1 * qy2 - qy1 * qx2 + qz1 * qw2
    return w, x, y, z

def rotate_vector_by_quaternion(vx, vy, vz, qw, qx, qy, qz):
    qqw, qqx, qqy, qqz = multiply_quaternions(qw, qx, qy, qz, 0, vx, vy, vz)
    return multiply_quaternions(qqw, qqx, qqy, qqz, qw, -qx, -qy, -qz)

def convert_quaternion_to_look_at(qw, qx, qy, qz):
    w, x, y, z = rotate_vector_by_quaternion(0, 0, 1, qw, qx, qy, qz)
    return x, y, z

def convert_quaternion_to_look_up(qw, qx, qy, qz):
    w, x, y, z = rotate_vector_by_quaternion(0, 1, 0, qw, qx, qy, qz)
    return x, y, z