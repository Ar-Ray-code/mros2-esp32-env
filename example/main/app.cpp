/* mros2 example
 * Copyright (c) 2021 smorita_emb
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "mros2.h"
#include "std_msgs/msg/bool.hpp"

#include "cmsis_os.h"
#include "wifi.h"

extern "C" void app_main(void)
{
  init_wifi();
  osKernelStart();

  printf("mbed mros2 start!\r\n");
  printf("app name: pub_bool\r\n");
  mros2::init(0, NULL);
  MROS2_DEBUG("mROS 2 initialization is completed\r\n");

  mros2::Node node = mros2::Node::create_node("mros2_node");
  mros2::Publisher pub = node.create_publisher<std_msgs::msg::Bool>("to_linux", 10);
  osDelay(100);
  MROS2_INFO("ready to pub/sub message\r\n");

  std_msgs::msg::Bool msg;
  bool data = true;
  while (1)
  {
    data = !data;
    msg.data = data;
    MROS2_INFO("publish: %d\r\n", msg.data);
    pub.publish(msg);
    osDelay(1000);
  }

  mros2::spin();
  return;
}