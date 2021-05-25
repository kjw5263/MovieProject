package mailtest;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
    
    public GoogleAuthentication(){
    	// 맥용 비밀번호 
        passAuth = new PasswordAuthentication("kjw5263", "njwtxrqrxlkyqjpz");
        
        // 윈도우 비밀번호 
        //passAuth = new PasswordAuthentication("kjw5263", "moxgyczrlwypwinr");
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}
