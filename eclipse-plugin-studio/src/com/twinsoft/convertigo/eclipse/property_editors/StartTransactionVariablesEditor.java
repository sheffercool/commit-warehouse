/*
 * Copyright (c) 2001-2018 Convertigo SA.
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see<http://www.gnu.org/licenses/>.
 */

package com.twinsoft.convertigo.eclipse.property_editors;

import org.eclipse.swt.widgets.Composite;

public class StartTransactionVariablesEditor extends TableEditor {
    
    public StartTransactionVariablesEditor(Composite parent) {
        super(parent);

        dialogTitle = "Starting transaction variables";
        columnNames = new String[] { "Context number", "Parameter name", "Parameter value" };
        templateData = new Object[] { "*", "name", "value" };
    }

}
