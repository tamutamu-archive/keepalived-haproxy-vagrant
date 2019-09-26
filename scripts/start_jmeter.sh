#!/bin/bash -e

/opt/apache-jmeter-5.1.1/bin/jmeter -n -t Test1.jmx -l result.jtl -e -o report
