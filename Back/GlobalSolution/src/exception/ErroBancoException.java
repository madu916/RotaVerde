package exception;

public class ErroBancoException extends RuntimeException {
    public ErroBancoException(String mensagem, Throwable causa) {
        super(mensagem, causa);
    }
}