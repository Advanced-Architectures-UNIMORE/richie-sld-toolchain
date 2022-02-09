/*
 * Copyright 2020 Xilinx, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <iostream>
#include <fstream>

#include "fir.h"

int main()
{
  data_t X[20] = {10, -4, 1, 7, 1, 1, 0, 0, 1, 1, 1, -6, -2, -1, 2, 2, 0, 0, 0, 0};
  coeff_t H[TAP] = {1, 2, 2, 1};
  sum_t Y = 0;
  int retval=0;
  ofstream FILE;

  // Save the results to a file
  FILE.open ("result.dat");

  ofstream myfile;
  std::stringstream stream;
  myfile.open ("golden_results.txt");

  for (int i = 0; i < 20; i++)
  {
    fir_dataflow(X[i], H, Y);
    cout << "Iter:" << setw(3) << right << i << " with x" << setw(3) << right
    << X[i] << " ###:" << setw(3) << right << Y << endl;
    FILE << Y << endl;
    // write results to file
    stream << std::hex << Y;
    myfile << stream.str();
    myfile << endl;
    stream.clear();
    stream.str("");
  }

  FILE.close();
  myfile.close();

  // Compare the results file with the golden results
  retval = system("diff --brief -w result.dat result.golden.dat");
  if (retval != 0) {
    cout << "Test failed  !!!" << endl; 
    retval=1;
  } else {
    cout << "Test passed !" << endl;
  }

  // Return 0 if the test
  return retval;
}
