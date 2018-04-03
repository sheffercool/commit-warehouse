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

package com.twinsoft.convertigo.eclipse.editors.jscript;

import org.eclipse.core.resources.IFile;
import org.eclipse.ui.part.FileEditorInput;

import com.twinsoft.convertigo.eclipse.views.projectexplorer.model.IFunctionTreeObject;

public class JscriptTreeFunctionEditorInput extends FileEditorInput {

	IFunctionTreeObject treeObject;
	
	public JscriptTreeFunctionEditorInput(IFile file) {
		super(file);
	}

	public JscriptTreeFunctionEditorInput(IFile file, IFunctionTreeObject functionTreeObject) {
		super(file);
		this.treeObject = functionTreeObject;
	}

	public IFunctionTreeObject getFunctionTreeObject() {
		return treeObject;
	}

	public void setFunctionTreeObject(IFunctionTreeObject treeObject) {
		this.treeObject = treeObject;
	}
}
