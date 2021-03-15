<#assign VOID = freeMarkerPortletPreferences.setValue("portletSetupPortletDecoratorId", "barebone")>

<@liferay_portlet["runtime"]
    defaultPreferences="${freeMarkerPortletPreferences}"
    portletName="com_liferay_jarvis_breadcrumb_portlet_BreadcrumbPortlet"
/>

<#assign VOID = freeMarkerPortletPreferences.reset()>