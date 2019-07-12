/*
 *  Copyright 2018 Carnegie Mellon University
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package edu.cmu.lti.oaqa.knn4qa.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class MiscHelper {
  public static String readFile(String inputFile) throws IOException {
    final BufferedReader  input = 
        new BufferedReader(
            new InputStreamReader(CompressUtils.createInputStream(inputFile)));

    StringBuffer sb = new StringBuffer();
    String s;
    while ((s=input.readLine()) != null) {
      sb.append(s);
      sb.append('\n');
    }
    input.close();
    return sb.toString();
  }
}