/*
 * Copyright 2000-2017 JetBrains s.r.o.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

///-------------------------------------------------
// Utility to show testConnectionDialog
///-------------------------------------------------
BS.TestConnectionDialog = OO.extend(BS.AbstractModalDialog, {
  hideOnMouseClickOutside: true,
  getContainer: function() {
    return $('testConnectionDialog');
  },

  show: function(success, details, nearElem) {
    if (details.length > 0) {
      details = details + '\n';
    }

    var testConnectionDetails = $('testConnectionDetails');
    var testConnectionStatus = $('testConnectionStatus');

    var preparedText = details.
      replace(/&/g, '&amp;').
      replace(/</g, '&lt;').
      replace(/\n/g, '<br>').
      replace(/ /g, '&nbsp;');
    if (preparedText.length > 0) {
      BS.Util.show(testConnectionDetails);
    } else {
      BS.Util.hide(testConnectionDetails);
    }

    if (success) {
      testConnectionStatus.innerHTML = 'Connection successful!';
      testConnectionStatus.className = 'testConnectionSuccess';
    } else {
      testConnectionStatus.innerHTML = 'Connection failed!';
      testConnectionStatus.className = 'testConnectionFailed';
    }

    this.showCentered();

    testConnectionDetails.style.height = '';
    testConnectionDetails.style.overflow = 'auto';
    testConnectionDetails.innerHTML = preparedText;

    var dim = testConnectionDetails.getDimensions();
    var dialogHeight = dim.height + 20; // horizontal scroll bar might be shown, so we should increase dialog height
    if (dialogHeight > 350) {
      testConnectionDetails.style.height = '300px';
    } else {
      testConnectionDetails.style.height = dialogHeight + 'px';
    }

    this.recenterDialog();
  }

});
