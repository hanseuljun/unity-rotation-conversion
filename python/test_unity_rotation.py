#!/usr/bin/env python3
import unity_rotation

def main():
    with open('../test_case.txt', 'r') as f:
        for line in f:
            words = line.split('/')
            quaternion = words[0].split(',')
            euler = words[1].split(',')
            qw, qx, qy, qz = unity_rotation.convert_euler_to_quaternion(float(euler[0]), float(euler[1]), float(euler[2]))
            print('quaternion: {}, {}, {}, {}'.format(quaternion[0], quaternion[1], quaternion[2], quaternion[3]))
            print('q: {}, {}, {}, {}'.format(qw, qx, qy, qz))

if __name__ == '__main__':
    main()