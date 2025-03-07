#!/bin/sh

echo "<result>$(system_profiler SPPowerDataType | grep "Cycle Count" | awk '{print $3}')</result>"

	