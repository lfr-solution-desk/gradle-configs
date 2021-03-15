<#-- add our custom navigation portlet -->
<#assign VOID =
	freeMarkerPortletPreferences.setValue("portletSetupPortletDecoratorId",
	"barebone")>

<@liferay_portlet["runtime"]
	defaultPreferences="${freeMarkerPortletPreferences}"
	portletName="com_liferay_jarvis_navigation_portlet_NavigationPortlet"
/>

<#assign VOID = freeMarkerPortletPreferences.reset()>