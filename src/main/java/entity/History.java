package entity;

public class History {
	private int id;
	private int characterId;
	private String characterName;
	private String image;
	private String viewTime;
	private String dateGroup; //
	
	public History() {}

	

	public History(int id, int characterId, String characterName, String image, String viewTime, String dateGroup) {
		super();
		this.id = id;
		this.characterId = characterId;
		this.characterName = characterName;
		this.image = image;
		this.viewTime = viewTime;
		this.dateGroup = dateGroup;
	}



	public int getCharacterId() {
		return characterId;
	}

	public void setCharacterId(int characterId) {
		this.characterId = characterId;
	}

	public String getCharacterName() {
		return characterName;
	}

	public void setCharacterName(String characterName) {
		this.characterName = characterName;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getViewTime() {
		return viewTime;
	}

	public void setViewTime(String viewTime) {
		this.viewTime = viewTime;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getDateGroup() {
		return dateGroup;
	}



	public void setDateGroup(String dateGroup) {
		this.dateGroup = dateGroup;
	}
	
	

}
