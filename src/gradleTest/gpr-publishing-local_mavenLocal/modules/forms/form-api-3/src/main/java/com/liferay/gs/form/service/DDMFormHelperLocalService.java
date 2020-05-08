/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.liferay.gs.form.service;

import com.liferay.dynamic.data.mapping.model.DDMDataProviderInstance;
import com.liferay.dynamic.data.mapping.model.DDMForm;
import com.liferay.dynamic.data.mapping.model.DDMFormInstance;
import com.liferay.dynamic.data.mapping.model.DDMFormLayout;
import com.liferay.dynamic.data.mapping.model.DDMStructure;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.service.ServiceContext;

import java.util.Locale;
import java.util.Map;

/**
 * @author Evandro Oliveira
 * @author Evandro Zeferino
 * @author Kayleen Lim
 */
public interface DDMFormHelperLocalService {

	public DDMFormInstance addAutoFillRule(
			JSONObject ddmRuleJSONObject, String formName,
			String dataProviderName, ServiceContext serviceContext)
		throws PortalException;

	public DDMFormInstance addDDMFormInstance(
			Map<Locale, String> nameMap, Map<Locale, String> descriptionMap,
			String jsonForm, ServiceContext serviceContext)
		throws PortalException;

	public DDMStructure addElementSet(
			String structureKey, Map<Locale, String> nameMap,
			Map<Locale, String> descriptionMap, String jsonElementSet,
			String jsonElementSetLayout, ServiceContext serviceContext)
		throws PortalException;

	public void deleteDDMFormInstance(String formName) throws PortalException;

	public DDMDataProviderInstance getDDMDataProviderInstance(
			String dataProviderName)
		throws PortalException;

	public DDMFormInstance getDDMFormInstanceByName(String formName)
		throws PortalException;

	public DDMFormInstance updateDDMFormInstance(
			DDMFormInstance formInstance, DDMForm ddmForm,
			ServiceContext serviceContext)
		throws PortalException;

	public DDMFormInstance updateDDMFormInstance(
			String formName, String jsonForm, ServiceContext serviceContext)
		throws PortalException;

	public DDMFormInstance updateDDMFormWithDataProviderInstance(
			String formName, String formFieldName, String dataProviderName,
			String dataProviderOutputParameterId, ServiceContext serviceContext)
		throws PortalException;

	public DDMStructure updateDDMStructureLayout(
			String formName, String jsonFormLayout,
			ServiceContext serviceContext)
		throws PortalException;

	public DDMStructure updateElementSet(
			DDMStructure ddmStructure, String jsonElementSet,
			String jsonElementSetLayout, ServiceContext serviceContext)
		throws PortalException;

}