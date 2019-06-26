library(tidyverse)
source("unity_rotation.R")

df.test.case <- read_csv("../test_case.txt", col_names = F) %>%
  rename(Quaternion.W = X1,
         Quaternion.X = X2,
         Quaternion.Y = X3) %>%
  separate(col = X4, into = c("Quaternion.Z", "Euler.X"), sep = "/") %>%
  rename(Euler.Y = X5) %>%
  separate(col = X6, into = c("Euler.Z", "Look.At.X"), sep = "/") %>%
  rename(Look.At.Y = X7) %>%
  separate(col = X8, into = c("Look.At.Z", "Look.Up.X"), sep = "/") %>%
  rename(Look.Up.Y = X9,
         Look.Up.Z = X10) %>%
  mutate_if(is.character, as.numeric)

df.quat <- convert_euler_to_quaternion(df.test.case$Euler.X,
                                       df.test.case$Euler.Y,
                                       df.test.case$Euler.Z)

sum(abs(df.test.case$Quaternion.W == df.quat$Quaternion.W) > 0.001)
sum(abs(df.test.case$Quaternion.X == df.quat$Quaternion.X) > 0.001)
sum(abs(df.test.case$Quaternion.Y == df.quat$Quaternion.Y) > 0.001)
sum(abs(df.test.case$Quaternion.Z == df.quat$Quaternion.Z) > 0.001)

df.look.at <- convert_quaternion_to_look_at(df.test.case$Quaternion.W,
                                            df.test.case$Quaternion.X,
                                            df.test.case$Quaternion.Y,
                                            df.test.case$Quaternion.Z)

sum(abs(df.test.case$Look.At.X == df.look.at$Look.At.X) > 0.001)
sum(abs(df.test.case$Look.At.Y == df.look.at$Look.At.Y) > 0.001)
sum(abs(df.test.case$Look.At.Z == df.look.at$Look.At.Z) > 0.001)

df.look.up <- convert_quaternion_to_look_up(df.test.case$Quaternion.W,
                                            df.test.case$Quaternion.X,
                                            df.test.case$Quaternion.Y,
                                            df.test.case$Quaternion.Z)

sum(abs(df.test.case$Look.Up.X == df.look.up$Look.Up.X) > 0.001)
sum(abs(df.test.case$Look.Up.Y == df.look.up$Look.Up.Y) > 0.001)
sum(abs(df.test.case$Look.Up.Z == df.look.up$Look.Up.Z) > 0.001)