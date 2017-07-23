package com.deppon.task.pojo;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 账户中心消费记录
 * @author twq
 *
 */
@Document(collection = "Ori_UgcIn_Account_turn_overInfo")
@Getter
@Setter
@ToString
public class OriUgcInAccountTurnOverInfo implements Serializable {

	private static final long serialVersionUID = 9108767841193165285L;

	@Id
	private String objectId;

	private String type;

	private String createDate;

	private String lastUpdateDate;

	private String account;

	private String fee;

	private String balance;

	private String currency;

	private String description;

	private String turnOverType;

	private String messageId;

	private String reasoncode;

	private String externalId;

	private String rechargeObjectId;

	private String bizDate;

	private String strdata;

	private String importTime;

	/**
	 * bean转换，mongo -> mysql
	 * @return
	 */
	/*public VirtualPaymentInfo toVirtualPaymentInfoWithoutScope() {
		VirtualPaymentInfo info = new VirtualPaymentInfo();
		info.setObjectId(objectId);
		info.setType(type);
		info.setCreateDate(createDate);
		info.setLastUpdateDate(lastUpdateDate);
		info.setAccount(account);
		info.setFee(Integer.valueOf(fee));
		info.setBalance(Integer.valueOf(balance));
		info.setCurrency(Integer.valueOf(currency));
		info.setDescription(description);
		info.setTurnoverType(Integer.valueOf(turnOverType));
		info.setMessageId(messageId);
		info.setReasonCode(reasoncode);
		info.setExternalId(externalId);
		info.setRechargeObjectId(rechargeObjectId);
		info.setStrData(strdata);
		info.setImportTime(new Date());
		info.setUpdateTime(new Date());
		//		private Integer scope;// 支付SCOPE
		return info;
	}*/

}
