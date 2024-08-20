class Problems{
    int problem_id;
    int asset_type_id;
    int network_type_id;
    String description;

    public void set_asset_type_id(int id){
        asset_type_id= id;
    }

    public void get_asset_type_id(){
        System.out.println("Hello");
        System.out.println(asset_type_id);
    }
}

class TestProblems{
     public static void main(String[] args){
        Problems prob1= new Problems();
        prob1.set_asset_type_id(11);
        prob1.get_asset_type_id();
    }

}