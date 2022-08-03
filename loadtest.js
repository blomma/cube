import http from "k6/http";
import { sleep } from "k6";

export const options = {
  stages: [
    { duration: "30s", target: 200 },
    { duration: "30s", target: 200 },
  ],
};

export default function () {
  http.get("http://192.168.1.11/weatherforecast");
  sleep(1);
}
