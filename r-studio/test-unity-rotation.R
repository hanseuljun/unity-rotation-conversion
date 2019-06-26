library(tidyverse)
source("unity-rotation.R")

test_case <- read_csv("../test_case.txt", col_names = F) %>%
  rename(quaternion_w = X1,
         quaternion_x = X2,
         quaternion_y = X3) %>%
  separate(col = X4, into = c("quaternion_z", "euler_x"), sep = "/") %>%
  rename(euler_y = X5) %>%
  separate(col = X6, into = c("euler_z", "look_at_x"), sep = "/") %>%
  rename(look_at_y = X7) %>%
  separate(col = X8, into = c("look_at_z", "look_up_x"), sep = "/") %>%
  rename(look_up_y = X9,
         look_up_z = X10) %>%
  mutate_if(is.character, as.numeric)

quaternion <- convert_euler_to_quaternion(test_case$euler_x,
                                          test_case$euler_y,
                                          test_case$euler_z)

sum(abs(test_case$quaternion_w == quaternion$quaternion_w) > 0.001)
sum(abs(test_case$quaternion_x == quaternion$quaternion_x) > 0.001)
sum(abs(test_case$quaternion_y == quaternion$quaternion_y) > 0.001)
sum(abs(test_case$quaternion_z == quaternion$quaternion_z) > 0.001)

look_at <- convert_quaternion_to_look_at(test_case$quaternion_w,
                                         test_case$quaternion_x,
                                         test_case$quaternion_y,
                                         test_case$quaternion_z)

sum(abs(test_case$look_at_x == look_at$look_at_x) > 0.001)
sum(abs(test_case$look_at_y == look_at$look_at_y) > 0.001)
sum(abs(test_case$look_at_z == look_at$look_at_z) > 0.001)

look_up <- convert_quaternion_to_look_up(test_case$quaternion_w,
                                         test_case$quaternion_x,
                                         test_case$quaternion_y,
                                         test_case$quaternion_z)

sum(abs(test_case$look_up_x == look_up$look_up_x) > 0.001)
sum(abs(test_case$look_up_y == look_up$look_up_y) > 0.001)
sum(abs(test_case$look_up_z == look_up$look_up_z) > 0.001)