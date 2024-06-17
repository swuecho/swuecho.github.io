class IO {
        constructor(effect) {
                this.effect = effect
                this.name = new Date();
        }

        static of(x) {
                return new IO(() => x)
        }

        static from(fn) {
                return new IO(fn)
        }

        map(fn) {
                console.log("map", this.effect)
                console.log("map", this.name)
                return new IO(() => {
                        console.log("new", this.name)
                        fn(this.effect())
                })
        }

        chain(fn) {
                return fn(this.effect())
        }

        run() {
                console.log("run", this.name)
                return this.effect()
        }
}

function f1() {
        console.log("f1")
        return 1
}

function f2() {
        console.log("f2")
        return 2
}

function f3() {
        console.log("f3")
        return 3
}


m1 = IO.from(f1).map(f2).map(f3)
console.log(m1);
console.log(m1.effect);
console.log("start run")
m1.run()
