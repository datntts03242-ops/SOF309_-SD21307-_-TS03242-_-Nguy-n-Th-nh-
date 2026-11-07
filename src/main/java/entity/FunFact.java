package entity;

public class FunFact {

    private int id;
    private String title;
    private String content;
    private int characterId;

    public FunFact() {}

	public FunFact(int id, String title, String content, int characterId) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.characterId = characterId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCharacterId() {
		return characterId;
	}

	public void setCharacterId(int characterId) {
		this.characterId = characterId;
	}
    
    
}
