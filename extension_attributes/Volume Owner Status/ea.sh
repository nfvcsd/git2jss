#!/bin/bash

# Setting a Recovery Lock password in a PreStage Enrollment on Fall 2021 MacBook 
# Pros shipping with macOS 12 causes there to be no volume owners on the Mac.
# This Jamf Pro extension attribute will detect computers that need remediation.

# Case 1. Set a status to display in case we run into an unexpected condition
STATUS='Unknown State'
# Intel or Silicon?
ARCHITECTURE=$(uname -p)
# Build version? 
BUILD_VERSION=$(sw_vers -buildVersion)
# We need to add the "-e" parameter when we call the updated xpath version in Big Sur
[[ ${BUILD_VERSION} > "20A" ]] && DASH_E='-e' || DASH_E=''
# List the crypto users on the root volume
PLIST=$(diskutil apfs listUsers / -plist)

if [[ ${ARCHITECTURE} == 'i386' ]]; then
  # Case 2. If Intel, no need to go further
  STATUS='[OK] Intel Device'
elif [[ ${ARCHITECTURE} == 'arm' ]]; then
  #   Check for no users state... 
  VOLUME_USER_COUNT=$(echo "${PLIST}" | xpath ${DASH_E} "count(/plist/dict/array/dict)" 2> /dev/null)
  if [[ VOLUME_USER_COUNT -eq 0 ]]; then
    # Case 3. There are no users on a volume early in the setup process.
    STATUS='No Users Yet'
  else
    VOLUME_OWNER_COUNT=$(echo "${PLIST}" | xpath ${DASH_E} "count(/plist/dict/array/dict/true[preceding-sibling::key='VolumeOwner'])" 2> /dev/null)
    if [[ ${VOLUME_OWNER_COUNT} -eq 0 ]]; then
      # Case 4. There are users, but none are owners. 
      STATUS='No Volume Owner Users'
    else
      # Case 5. There are owner users on this volume
      STATUS='[OK] Volume Owners found'
    fi
  fi
fi
echo "<result>${STATUS}</result>"


# Copyright 2021 JAMF Software, LLC
# 
# THE SOFTWARE IS PROVIDED "AS-IS," WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL JAMF SOFTWARE,
# LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN CONTRACT, TORT, OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OF OR OTHER DEALINGS IN THE SOFTWARE,
# INCLUDING BUT NOT LIMITED TO DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# CONSEQUENTIAL OR PUNITIVE DAMAGES AND OTHER DAMAGES SUCH AS LOSS OF USE,
# PROFITS, SAVINGS, TIME OR DATA, BUSINESS INTERRUPTION, OR PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES.