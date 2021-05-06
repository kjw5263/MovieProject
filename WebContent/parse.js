const awesomeHeaders = new Headers();
awesomeHeaders.append("X-Naver-Client-Id", "Kyfh22pzlli_1dQYrgkl");
awesomeHeaders.append("X-Naver-Client-Secret", "rWZw6ljF9q");

fetch("https://openapi.naver.com/v1/search/movie.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&genre=1")
  .then(response => response.json())
  .then(json => console.log(json));