#!/bin/sh

echo "<result>$(system_profiler SPPowerDataType | grep "Condition" | awk '{print $2}')</result>"

	