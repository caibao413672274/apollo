/** 
 * 创建日期:2013-9-9 
 *
 * 文件名：SecurityUtil.java 
 *
 * author:CZQ 
 *
 * 备注:
 *
 */
package com.ctrip.framework.apollo.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.SecureRandom;


/**
 * 加密工具类
 * 
 * @author CZQ
 * 
 * @date 2013-9-9
 * 
 */
public class EncryUtil {
	private final static String AES = "AES";
	private static String DES = "DES";
	private  final static String UTF8="UTF-8";
	/**
	 * Aes加解密key
	 */
	private  static String AESKEY = null; 


	/**
	 * 将字符串进行MD5加密
	 * 
	 * @author CZQ
	 * 
	 * @date 2013-9-9
	 * 
	 * @param str
	 * @return
	 */
	public static String encryMd5(String str) {
		// System.out.println("result: " +
		// buf.toString().substring(8,24));//16位的加密
		return byte2hex(getMD5Digests(str));
	}

	/**
	 * 将字符串转换为SHA1算法的字节数值
	 * 
	 * @author CZQ
	 * 
	 * @date 2013-9-9
	 * 
	 * @param data
	 * @return
	 */
	private static byte[] getSHA1Digest(String data) {
		byte[] bytes = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			bytes = md.digest(data.getBytes(UTF8));
		} catch (Exception gse) {

		}
		return bytes;
	}

	/**
	 * 将字符串转换为MD5算法的字节数值
	 * 
	 * @author CZQ
	 * 
	 * @date 2013-9-9
	 * 
	 * @param data
	 * @return
	 */
	private static byte[] getMD5Digests(String data) {
		byte[] bytes = null;
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			bytes = md.digest(data.getBytes(UTF8));
		} catch (Exception gse) {

		}
		return bytes;
	}

	/**
	 * 二进制转十六进制字符串
	 * 
	 * @param bytes
	 * @return
	 */
	public static String byte2hex(byte[] bytes) {
		if (bytes == null)
			return "";

		StringBuilder sign = new StringBuilder();
		for (int i = 0; i < bytes.length; i++) {
			String hex = Integer.toHexString(bytes[i] & 0xFF);
			if (hex.length() == 1) {
				sign.append("0");
			}
			sign.append(hex.toUpperCase());
		}
		return sign.toString();
	}

	/**
	 * 十六进制字符串转化为2进制
	 * 
	 * @param hex
	 * @return
	 */
	public static byte[] hex2byte(String hex) {
		try {
			if (hex.length() < 1)
				return null;
			int length = hex.length() / 2;
			byte[] ret = new byte[length];
			byte[] tmp = hex.getBytes();
			for (int i = 0; i < length; i++) {
				ret[i] = uniteBytes(tmp[i * 2], tmp[i * 2 + 1]);
			}
			return ret;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	/**
	 * 将两个ASCII字符合成一个字节； 如："EF"--> 0xEF
	 * 
	 * @param src0
	 *            byte
	 * @param src1
	 *            byte
	 * @return byte
	 */
	public static byte uniteBytes(byte src0, byte src1) {
		byte _b0 = Byte.decode("0x" + new String(new byte[] { src0 }))
				.byteValue();
		_b0 = (byte) (_b0 << 4);
		byte _b1 = Byte.decode("0x" + new String(new byte[] { src1 }))
				.byteValue();
		byte ret = (byte) (_b0 ^ _b1);
		return ret;
	}

	/**
	 * AES 加密 AES Description 根据键值进行加密
	 * 
	 * @param data
	 *
	 *            加密键byte数组
	 * @return
	 * @throws Exception
	 */
	public static String encryptAES(String data) throws Exception {
		if (data == null || data.isEmpty())
			return "";
		byte[] bt = encryptAes(data.getBytes("UTF-8"));

		String strs = byte2hex(bt);
		return strs;
	}

	/**
	 * AES 解密 AES Description 根据键值进行解密
	 * 
	 * @param data
	 *
	 *            加密键byte数组
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public static String decryptAES(String data) {
		if (data == null || data.isEmpty())
			return "";

		try {
			byte[] buf = hex2byte(data);
			byte[] bt = decryptAes(buf);
			if (bt == null)
				return "";
			return new String(bt,"UTF-8");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return "";
		}

	}

	/**
	 * 
	 * Description 根据键值进行加密
	 * 
	 * @param data
	 *            需要加密的内容
	 * @return 返回加密后的字节
	 * @throws Exception
	 */
	private static byte[] encryptAes(byte[] data) throws Exception {
		if (data == null || data.length <= 1)
			return null;
		// 为了和.NET加密一致修改为
		byte[] enCodeFormat = AESKEY.getBytes();
		// ///////////////////////以上已经修改/////////////////////////
		SecretKeySpec key = new SecretKeySpec(enCodeFormat, AES);
		// Cipher对象实际完成加密操作
		Cipher cipher = Cipher.getInstance(AES);

		cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化

		return cipher.doFinal(data);
	}
	/**
	 * DES加密
	 * @author CZQ
	 *
	 * @date 2016-8-12
	 *
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static String encryptDES(String data) throws Exception{
		SecureRandom random = new SecureRandom();
		DESKeySpec desKey = new DESKeySpec(AESKEY.getBytes());
		// 创建一个密匙工厂，然后用它把DESKeySpec转换成
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
		SecretKey securekey = keyFactory.generateSecret(desKey);
		// Cipher对象实际完成加密操作
		Cipher cipher = Cipher.getInstance(DES);
		// 用密匙初始化Cipher对象
		cipher.init(Cipher.ENCRYPT_MODE, securekey, random);
		// 现在，获取数据并加密
		// 正式执行加密操作
		byte[] bytes= cipher.doFinal(data.getBytes("UTF-8"));
		String strs = byte2hex(bytes);
		return strs;
	}
	/**
	* 解密
	* @param data
	* @return byte[]
	* @throws Exception
	*/
	public static String decryptDES(String data) throws Exception {
	// DES算法要求有一个可信任的随机数源
	SecureRandom random = new SecureRandom();
	// 创建一个DESKeySpec对象
	DESKeySpec desKey = new DESKeySpec(AESKEY.getBytes());
	// 创建一个密匙工厂
	SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
	// 将DESKeySpec对象转换成SecretKey对象
	SecretKey securekey = keyFactory.generateSecret(desKey);
	// Cipher对象实际完成解密操作
	Cipher cipher = Cipher.getInstance("DES");
	// 用密匙初始化Cipher对象
	cipher.init(Cipher.DECRYPT_MODE, securekey, random);
	// 真正开始解密操作
	return    new String(cipher.doFinal(hex2byte(data)),"UTF-8");
	}
	

	
	static{
		StringBuilder s=new StringBuilder();
		s.append(get0()).append(get1()).append(get2()).append(get3()).append(get4())
		.append(get5()).append(get6()).append(get7()).append(get8()).append(get9())
		.append(get10()).append(get11()).append(get12()).append(get13()).append(get14())
		.append(get15())
		;
		AESKEY=s.toString();

		s=null;
	}
	private static char get0(){
		return (char)117;
	}
	private static char get1(){
		return (char)110;
	}
	private static char get2(){
		return (char)105;
	}
	private static char get3(){
		return (char)116;
	}
	private static char get4(){
		return (char)111;
	}
	private static char get5(){
		return (char)112;
	}
	private static char get6(){
		return (char)46;
	}
	private static char get7(){
		return (char)99;
	}

	 
	/**
	 * Description 根据键值进行解密
	 * 
	 * @param data
	 *            加密键byte数组
	 * @return
	 * @throws Exception
	 */
	private static byte[] decryptAes(byte[] data) throws Exception {
		if (data == null || data.length <= 1)
			return null;
		// 为了和.NET加密一致修改为
		byte[] enCodeFormat = AESKEY.getBytes();
		// ///////////////////////以上已经修改/////////////////////////
		SecretKeySpec key = new SecretKeySpec(enCodeFormat, AES);
		// Cipher对象实际完成加密操作
		Cipher cipher = Cipher.getInstance(AES);

		cipher.init(Cipher.DECRYPT_MODE, key);// 初始化

		return cipher.doFinal(data);
	}
	private static char get8(){
		return (char)111;
	}
	private static char get9(){
		return (char)109;
	}
	private static char get10(){
		return (char)33;
	}
	private static char get11(){
		return (char)64;
	}
	private static char get12(){
		return (char)35;
	}
	private static char get13(){
		return (char)36;
	}
	private static char get14(){
		return (char)37;
	}
	private static char get15(){
		return (char)94;
	}
}
