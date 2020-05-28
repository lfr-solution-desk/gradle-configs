package com.liferay.gs.form.service;

import com.liferay.dynamic.data.mapping.model.DDMFormInstance;
import com.liferay.portal.kernel.exception.PortalException;

import org.osgi.framework.Bundle;
import org.osgi.framework.FrameworkUtil;
import org.osgi.util.tracker.ServiceTracker;

public class DDMFormHelperLocalServiceUtil {

	public static DDMFormInstance getDDMFormInstanceByName(String formName)
		throws PortalException {
		return _getService().getDDMFormInstanceByName(formName);
	}

	private static DDMFormHelperLocalService _getService() {
		return _serviceTracker.getService();
	}

	private static ServiceTracker
		<DDMFormHelperLocalService, DDMFormHelperLocalService> _serviceTracker;

	static {
		Bundle bundle = FrameworkUtil.getBundle(DDMFormHelperLocalService.class);

		ServiceTracker<DDMFormHelperLocalService, DDMFormHelperLocalService>
			serviceTracker =
			new ServiceTracker
				<>(
					bundle.getBundleContext(),
					DDMFormHelperLocalService.class, null
				);

		serviceTracker.open();

		_serviceTracker = serviceTracker;
	}

}
