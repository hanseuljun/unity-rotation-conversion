#!/usr/bin/env python3
import unity_rotation

def convert_words(words):
    for i in range(len(words)):
        words[i] = float(words[i])
    return words

def convert_line(line):
    words = line.split('/')
    quaternion = convert_words(words[0].split(','))
    euler = convert_words(words[1].split(','))
    look_at = convert_words(words[2].split(','))
    look_up = convert_words(words[3].split(','))
    return quaternion, euler, look_at, look_up

def main():
    with open('../test_case.txt', 'r') as f:
        for line in f:
            quaternion, euler, look_at, look_up = convert_line(line)
            qw, qx, qy, qz = unity_rotation.convert_euler_to_quaternion(euler[0], euler[1], euler[2])
            print('quaternion: {}, {}, {}, {}'.format(quaternion[0], quaternion[1], quaternion[2], quaternion[3]))
            print('q: {}, {}, {}, {}'.format(qw, qx, qy, qz))

if __name__ == '__main__':
    main()