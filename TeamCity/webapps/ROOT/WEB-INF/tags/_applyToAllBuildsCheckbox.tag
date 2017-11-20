<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><%@ attribute name="prefix" required="true" type="java.lang.String"

%><div class="tagsApplyAll" style="display: none;">
  <forms:checkbox name="applyToChainBuilds" id="${prefix}_applyToChainBuilds"/>
  <label for="${prefix}_applyToChainBuilds">apply tags to all snapshot dependencies</label>
  <bs:smallNote>Note: existing tags in dependent builds will <i>not</i> be removed</bs:smallNote>
</div>
