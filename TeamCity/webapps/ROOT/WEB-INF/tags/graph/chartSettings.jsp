<%--@elvariable id="id" type="java.lang.String"--%>
<div class="graphSettingsPopup">
  <div class="popupInput">
    <label>
      <input type="checkbox" id="axis.y.includeZero" name="@yZero" onclick="this.value = (this.checked ? 'true' : 'false');"/>
      Always include zero
    </label>
  </div>
  <div class="popupInput">
    <label>
      <input type="checkbox" id="axis.y.type" name="@yType" onclick="this.value = (this.checked ? 'logarithmic' : 'default');"/>
      Use logarithmic scale
    </label>
  </div>
  <div class="popupInput popupInputField">
    <label>Max value:</label>
    <input type="text" id="axis.y.max" name="@yMax"/>
  </div>
  <div class="popupInput popupInputField">
    <label>Min value:</label>
    <input type="text" id="axis.y.min" name="@yMin"/>
  </div>
  <div class="smallNote">Mouse drag chart to zoom on X. Ctrl-drag to zoom on both axes.</div>
  <div class="saveButtonsBlock">
    <button class="btn btn_primary submitButton">Apply</button>
    <button class="btn cancel">Cancel</button>
    <button class="btn saveDefaults">Save as defaults</button>
  </div>
</div>
