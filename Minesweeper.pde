import de.bezier.guido.*;
private MSButton[][] buttons; 
private ArrayList <MSButton> mines; 
int NUM_ROWS = 20;
int NUM_COLS = 20;
boolean loser = false;
int tileCount = 0;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);

    buttons = new MSButton [NUM_ROWS] [NUM_COLS];
    mines = new ArrayList <MSButton>();
    for(int i = 0;i<NUM_COLS;i++)
    {
        for(int j = 0; j < NUM_ROWS;j++){
            buttons[j][i]= new MSButton(j,i);
    }
}
    
    
    setMines();
}
public void setMines()
{  for (int i = 0; i < 40; i++) {
    final int r1 = (int)(Math.random()*NUM_ROWS);
    final int r2 = (int)(Math.random()*NUM_COLS);
    if ((mines.contains (buttons[r1][r2])) == false) {
      mines.add(buttons[r1][r2]);
    }
    else {i +=-1;}
}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();

    for (int i = 0; i < NUM_ROWS; i++) {
     for (int j = 0; j < NUM_COLS; j++) {
        buttons[i][j].draw();
      } 
    }
    
}
public boolean isWon()
{  
  
  return false;
}
public void displayLosingMessage()
{  
    
    for(int i=0;i<mines.size();i++)
        if(mines.get(i).isClicked()==false)
            mines.get(i).mousePressed();
    loser = true;
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("L");
    buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("S");
    buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("E");
}
public void displayWinningMessage()
{
    loser = true;
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("W");
    buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("I");
    buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("N");
    buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("!");
}

//new
public void mousePressed (){
  int mX = mouseX;
  int mY = mouseY;
  buttons[(int)(mY/NUM_COLS)][(int)(mX/NUM_ROWS)].mousePressed();
}
//end

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;

    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    
    public void mousePressed () 
    {
      if (loser == false) {
        if (mouseButton == RIGHT && buttons[r][c].isClicked()) {
         
        }
        else if (mouseButton == RIGHT) {
          marked = !marked;
        }
        else if (marked == true) {}
        else if (mines.contains(this)) {
          clicked = true;
          displayLosingMessage();
        }
        else if (countBombs(r,c) > 0) {
          label = ""+countBombs(r,c);
          if (!clicked) {tileCount+=1;}
          if (tileCount == 400-mines.size()) {displayWinningMessage();}
          clicked = true;
        }
        else {

          
          if (!clicked) {tileCount+=1;}
          if (tileCount == 400-mines.size()) {displayWinningMessage();}
          clicked = true;
          
          if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()) {
          buttons[r-1][c-1].mousePressed();} 
          if(isValid(r-1,c) && !buttons[r-1][c].isClicked()) {
          buttons[r-1][c].mousePressed();}
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()){
          buttons[r-1][c+1].mousePressed();}
          
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked()){
          buttons[r][c-1].mousePressed();}
          if(isValid(r,c+1) && !buttons[r][c+1].isClicked()){
          buttons[r][c+1].mousePressed();}
          
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()){
          buttons[r+1][c-1].mousePressed();}
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked()){
          buttons[r+1][c].mousePressed();}
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()){
          buttons[r+1][c+1].mousePressed();}
        }
      }
    }

    public void draw () 
    {    
      if (marked)
            fill(0);
         
         else if( !marked && clicked && mines.contains(this) ) 
             fill(120, 201, 245);
         else if( marked && mines.contains(this) ) 
             fill(200);
         else if( !marked && clicked && !mines.contains(this) ) 
             fill(152, 56, 242);
             
        else if(clicked)
            fill(200);
        else 
            fill(50, 8, 158);

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r <NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0) {return true;}
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row-1,col) == true && mines.contains(buttons[row-1][col]))
        {
            numBombs++;
        }
        if (isValid(row+1,col) == true && mines.contains(buttons[row+1][col]))
        {
            numBombs++;
        }
         if (isValid(row,col-1) == true && mines.contains(buttons[row][col-1]))
        {
            numBombs++;
        }
         if (isValid(row,col+1) == true && mines.contains(buttons[row][col+1]))
        {
            numBombs++;
        }
         if (isValid(row-1,col+1) == true && mines.contains(buttons[row-1][col+1]))
        {
            numBombs++;
        }
         if (isValid(row-1,col-1) == true && mines.contains(buttons[row-1][col-1]))
        {
            numBombs++;
        }
         if (isValid(row+1,col+1) == true && mines.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }
         if (isValid(row+1,col-1) == true && mines.contains(buttons[row+1][col-1]))
        {
            numBombs++;
        }
        return numBombs;
    }
}
