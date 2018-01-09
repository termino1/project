package com.icia.bachida.util;

import java.beans.*;
import java.util.*;

import com.icia.bachida.vo.*;


public class AuthorityPropertyEditor extends PropertyEditorSupport {
	@Override // 객체로
    public void setAsText(String text) {
		List<Authority> list = new ArrayList<Authority>();
		if(text.equals("ROLE_USER"))
			list.add(new Authority("ROLE_USER"));
		else if(text.equals("ROLE_MANAGER")) {
			list.add(new Authority("ROLE_USER"));
			list.add(new Authority("ROLE_MANAGER"));
		} else if(text.equals("ROLE_ADMIN")) {
			list.add(new Authority("ROLE_USER"));
			list.add(new Authority("ROLE_MANAGER"));
			list.add(new Authority("ROLE_ADMIN"));
		}
		setValue(list);
    }
}
