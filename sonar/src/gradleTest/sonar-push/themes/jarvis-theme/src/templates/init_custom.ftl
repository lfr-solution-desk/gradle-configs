<#assign
	page_name = page.getName('en_US')?lower_case?trim
	is_search_results_page = (theme_display.getPpid() == "com_liferay_jarvis_search_portlet_NavigationSearchPortlet")
	is_home_page = (page_name == 'home')
	jarvis_page = 'jarvis-' + page_name
/>

<#if !is_search_results_page>
	<#assign css_class = css_class + ' ' + jarvis_page />
</#if>