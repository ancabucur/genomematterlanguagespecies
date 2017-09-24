import gohai.glvideo.*;

class Film {
  String edgesPath = "../data/video/edges.glsl";
  GLMovie movie;
  PShader edges;
  boolean edgesEnabled = false;
  boolean isPlaying = false;

  public Film(PApplet parent) {
    movie = new GLMovie(parent, FILM);
    edges = loadShader(edgesPath);
    movie.loop();
    isPlaying = true;
    movie.volume(0);
  }

  public Film(PApplet parent, String pathToFilm) {
    movie = new GLMovie(parent, pathToFilm);
    edges = loadShader(edgesPath);
  }

  void play() {
    if (!isPlaying || movie.time() >= movie.duration())
    {
      movie.play();
      movie.volume(0);
    }
    isPlaying = true;
  }

  void pause()
  {
    if (isPlaying)
      movie.pause();
    isPlaying = false;
  }

  void enableEdges() {
    if (!edgesEnabled)
      shader(edges);
    edgesEnabled = true;
  }

  void disableEdges() {
    if (edgesEnabled)
      resetShader();
    edgesEnabled = false;
  }

  void update(boolean edges) {
    if (movie.available()) {
      movie.read();
    }
    if (edges == true) 
      enableEdges();
    else
      disableEdges();

    image(movie, 0, 0, width, height);
  }
}