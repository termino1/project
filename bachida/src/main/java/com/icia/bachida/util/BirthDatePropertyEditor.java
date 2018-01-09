package com.icia.bachida.util;

import java.beans.*;

public class BirthDatePropertyEditor extends PropertyEditorSupport {
	@Override // 객체로
    public void setAsText(String text) {
		String str = text.replace("-", "");
		setValue(str);
    }
}
