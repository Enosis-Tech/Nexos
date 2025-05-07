public class Main {
	public static void main(String[] args) {

		Carro carro = new Carro("Ferrari");

		System.out.println(carro.getMarca());
	}
}

class Carro {

	private String marca;

	public Carro(String marca) {
		this.marca = marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public String getMarca() {
		return this.marca;
	}

}