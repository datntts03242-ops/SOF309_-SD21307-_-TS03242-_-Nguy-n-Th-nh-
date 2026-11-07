package entity;

public class Artiface {

    private int id;
    private int dynastyId;

    private String name;
    private String description;
    private String biography;

    private String origin;
    private String material;

    private String discoveredPlace;
    private String discoveredYear;

    private String currentLocation;

    private String image;
    private String youtubeLink;

    private boolean isDeleted;

    public Artiface() {
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDynastyId() {
		return dynastyId;
	}

	public void setDynastyId(int dynastyId) {
		this.dynastyId = dynastyId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	public String getDiscoveredPlace() {
		return discoveredPlace;
	}

	public void setDiscoveredPlace(String discoveredPlace) {
		this.discoveredPlace = discoveredPlace;
	}

	public String getDiscoveredYear() {
		return discoveredYear;
	}

	public void setDiscoveredYear(String discoveredYear) {
		this.discoveredYear = discoveredYear;
	}

	public String getCurrentLocation() {
		return currentLocation;
	}

	public void setCurrentLocation(String currentLocation) {
		this.currentLocation = currentLocation;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getYoutubeLink() {
		return youtubeLink;
	}

	public void setYoutubeLink(String youtubeLink) {
		this.youtubeLink = youtubeLink;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

 
    

	
}