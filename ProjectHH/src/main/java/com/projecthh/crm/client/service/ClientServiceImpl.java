package com.projecthh.crm.client.service;

import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.projecthh.crm.client.DAO.ClientDAO;
import com.projecthh.crm.client.vo.ClientVO;

@Service("clientService")
public class ClientServiceImpl implements ClientService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "clientDAO")
	private ClientDAO clientDAO;

	@Override
	public ArrayList<ClientVO> searchClient(Map<String, Object> map) {
		return clientDAO.searchClient(map);
	}

	@Override
	public ClientVO selectClient(String no) {
		return clientDAO.selectClient(no);
	}

	@Override
	public void updateClient(Map<String, Object> commandMap) {
		clientDAO.updateClient(commandMap);
	}

	@Override
	public void deleteClient(String no) {
		clientDAO.deleteClient(no);
	}

	@Override
	public void insertClient(Map<String, Object> commandMap) {
		clientDAO.insertClient(commandMap);
	}

	@Override
	public String selectNo(String bno) {
		return clientDAO.selectNo(bno);
	}

	@Override
	public int searchClientCount(Map<String, Object> map) {
		return clientDAO.searchClientCount(map);
	}

	@Override
	public ClientVO login(ClientVO vo) {

		return clientDAO.login(vo);
	}


}