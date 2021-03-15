<!DOCTYPE html>

<#include init />

<html class="${root_css_class}" dir="<@liferay.language key="lang.dir" />" lang="${w3c_language_id}">

<head>
	<title>${the_title} - ${company_name}</title>

	<meta content="initial-scale=1.0, width=device-width" name="viewport" />

	<@liferay_util["include"] page=top_head_include />
</head>

<body class="${css_class}">

<@liferay_ui["quick-access"] contentId="#main-content" />

<@liferay_util["include"] page=body_top_include />

<@liferay.control_menu />

<div id="wrapper">
	<#if is_signed_in>
		<div class="header-wrapper">
			<header class="container-fluid flex-container header" id="banner" role="banner">
				<a class="${logo_css_class}" href="${site_default_url}" title="<@liferay.language_format arguments="${site_name}" key="go-to-x"/>">
					<h1 class="site-title">
						<svg class="fa-globe-americas fa-icon">
							<use xlink:href="${images_folder}/jarvis/icons/icons.svg#globe-americas" />
						</svg>
					</h1>
				</a>

				<#if has_navigation && is_setup_complete>
					<#include "${full_templates_path}/navigation.ftl" />
				</#if>

				<div class="header-search">
					<div class="header-page-title">
						${site_name}
					</div>

					<#-- add our custom search portlet -->
					<#assign VOID =
						freeMarkerPortletPreferences.setValue("portletSetupPortletDecoratorId",
						"barebone")>

					<@liferay_portlet["runtime"]
						defaultPreferences="${freeMarkerPortletPreferences}"
						portletName="com_liferay_jarvis_search_portlet_NavigationSearchPortlet"
					/>

					<#assign VOID = freeMarkerPortletPreferences.reset()>
				</div>

				<div class="header-user-interaction">
					<div class="toggle-control-menu-wrapper">
						<a class="js-toggle-control-menu toggle-control-menu">
							<svg class="fa-angle-down fa-icon rotate-180">
								<use xlink:href="${images_folder}/jarvis/icons/icons.svg#angle-down" />
							</svg>

							<svg class="fa-angle-down fa-icon">
								<use xlink:href="${images_folder}/jarvis/icons/icons.svg#angle-down" />
							</svg>
						</a>
					</div>

					<@liferay.user_personal_bar />
				</div>
			</header>

			<header class="sub-navigation">
				<div class="container-fluid flex-container header">
					<#include "${full_templates_path}/breadcrumb.ftl" />

					<#--  commenting this out since sub navigation portlet isn't in use as of 7/24/18  -->
					<#--  <#if has_navigation && is_setup_complete>
						<#include "${full_templates_path}/sub_navigation.ftl" />
					</#if>  -->

					<#assign VOID = freeMarkerPortletPreferences.reset()>

					<#-- add menu aggregator portlet to every page -->
					<#assign VOID =
						freeMarkerPortletPreferences.setValue("portletSetupPortletDecoratorId",
						"barebone")>

						<@liferay_portlet["runtime"]
						defaultPreferences="${freeMarkerPortletPreferences}"
						portletName="com_liferay_jarvis_menu_aggregator_MenuAggregatorPortlet"
					/>

					<#assign VOID = freeMarkerPortletPreferences.reset()>
				</div>
			</header>
		</div>
	</#if>

	<section class="container-fluid" id="content">
		<h1 class="hide-accessible">${the_title}</h1>

		<div id="content-inner-wrapper">
			<#if selectable>
				<@liferay_util["include"] page=content_include />
			<#else>
				${portletDisplay.recycle()}

				${portletDisplay.setTitle(the_title)}

				<@liferay_theme["wrap-portlet"] page="portlet.ftl">
					<@liferay_util["include"] page=content_include />
				</@>
			</#if>
		</div>

		<footer id="footer" role="contentinfo">
		</footer>
	</section>
</div>

<@liferay_util["include"] page=body_bottom_include />

<@liferay_util["include"] page=bottom_include />

<!-- inject:js -->
<!-- endinject -->

</body>

</html>