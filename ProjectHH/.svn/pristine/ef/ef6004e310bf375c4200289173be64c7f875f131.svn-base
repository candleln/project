package com.projecthh.crm.client.service;

import java.util.ArrayList;
import java.util.Map;

import com.projecthh.crm.client.vo.ClientVO;

public interface ClientService {

	ArrayList<ClientVO> searchClient(Map<String, Object> map) throws Exception;

	ClientVO selectClient(String no) throws Exception;

	void updateClient(Map<String, Object> commandMap);

	void deleteClient(String no);

	void insertClient(Map<String, Object> commandMap);

	String selectNo(String bno);

	int searchClientCount(Map<String, Object> map);

	ClientVO login(ClientVO vo);

}