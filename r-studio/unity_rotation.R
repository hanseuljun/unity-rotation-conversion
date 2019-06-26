library(tidyverse)

deg2rad <- function(degree) {
  return(degree * pi / 180)
}

convert_euler_to_quaternion <- function(pitch, yaw, roll) {
  # pitch
  sp = sin(deg2rad(pitch) * 0.5)
  cp = cos(deg2rad(pitch) * 0.5)
  # yaw
  sy = sin(deg2rad(yaw) * 0.5)
  cy = cos(deg2rad(yaw) * 0.5)
  # roll
  sr = sin(deg2rad(roll) * 0.5)
  cr = cos(deg2rad(roll) * 0.5)
  
  qw = cy * cr * cp + sy * sr * sp
  qz = cy * sr * cp - sy * cr * sp
  qx = cy * cr * sp + sy * sr * cp
  qy = sy * cr * cp - cy * sr * sp
  return(matrix(c(qw, qx, qy, qz), ncol = 4) %>%
           as_tibble(.name_repair = "unique") %>%
           rename(Quaternion.W = names(.)[1],
                  Quaternion.X = names(.)[2],
                  Quaternion.Y = names(.)[3],
                  Quaternion.Z = names(.)[4]))
}

multiply_quaternions <- function(qw1, qx1, qy1, qz1, qw2, qx2, qy2, qz2) {
  w = qw1 * qw2 - qx1 * qx2 - qy1 * qy2 - qz1 * qz2
  x = qw1 * qx2 + qx1 * qw2 + qy1 * qz2 - qz1 * qy2
  y = qw1 * qy2 - qx1 * qz2 + qy1 * qw2 + qz1 * qx2
  z = qw1 * qz2 + qx1 * qy2 - qy1 * qx2 + qz1 * qw2
  #return(c(w, x, y, z))
  return(matrix(c(w, x, y, z), ncol = 4) %>%
           as_tibble(.name_repair = "unique") %>%
           rename(Quaternion.W = names(.)[1],
                  Quaternion.X = names(.)[2],
                  Quaternion.Y = names(.)[3],
                  Quaternion.Z = names(.)[4]))
}

rotate_vector_by_quaternion <- function(vx, vy, vz, qw, qx, qy, qz) {
  qq = multiply_quaternions(qw, qx, qy, qz, 0, vx, vy, vz)
  return(multiply_quaternions(qq$Quaternion.W,
                              qq$Quaternion.X,
                              qq$Quaternion.Y,
                              qq$Quaternion.Z,
                              qw, -qx, -qy, -qz))
}

convert_quaternion_to_look_at <- function(qw, qx, qy, qz) {
  return(rotate_vector_by_quaternion(0, 0, 1, qw, qx, qy, qz) %>%
           select(-Quaternion.W) %>%
           rename(Look.At.X = Quaternion.X,
                  Look.At.Y = Quaternion.Y,
                  Look.At.Z = Quaternion.Z))
}

convert_quaternion_to_look_up <- function(qw, qx, qy, qz) {
  return(rotate_vector_by_quaternion(0, 1, 0, qw, qx, qy, qz) %>%
           select(-Quaternion.W) %>%
           rename(Look.Up.X = Quaternion.X,
                  Look.Up.Y = Quaternion.Y,
                  Look.Up.Z = Quaternion.Z))
}