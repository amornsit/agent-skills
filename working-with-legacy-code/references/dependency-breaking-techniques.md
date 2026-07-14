# Dependency-Breaking Techniques

The catalog from Ch. 25 of Michael Feathers' *Working Effectively with Legacy Code*.
Each technique gets code under test by removing a specific obstacle. Two obstacles
recur: **you can't instantiate the class** in a harness, or **you can't run the
method** in one. Pick the least invasive technique that clears yours.

Because you often apply these *before* you have tests, work in tiny, mechanical,
compiler-checked steps — prefer moves the compiler verifies (introduce interface,
add parameter) over ones it can't. In OO languages, favor **object seams** (Subclass
and Override Method, Extract Interface, Parameterize Constructor).

## Introducing object seams (vary a call or collaborator)

- **Extract Interface** — *A concrete collaborator blocks you.* Pull an interface from
  it; depend on the interface; pass a fake in tests. The safest, most portable move.
- **Extract Implementer** — *Can't add an interface above a class* (naming/ownership).
  Make the class itself the interface by pushing its implementation down into a new
  subclass; tests supply their own implementer.
- **Subclass and Override Method** — *Core technique.* Subclass the class under test
  and override the method whose behavior you need to neutralize or sense. Requires the
  method be overridable (virtual / non-private).
- **Extract and Override Call** — *A hard-to-test call sits inside a method.* Move the
  call into its own protected method, then override that method in a testing subclass.
- **Extract and Override Factory Method** — *A constructor call inside a method* creates
  something you can't have under test. Move the `new` into a protected factory method
  and override it to return a fake.
- **Extract and Override Getter** — *A field holds an awkward object.* Access it only
  through a getter, then override the getter in a subclass to return a fake (lazily).
- **Parameterize Constructor** — *The constructor creates a dependency internally.* Add
  a constructor parameter for it (defaulting to the real one), so tests pass a fake.
- **Parameterize Method** — *A method creates an object it uses internally.* Add a
  parameter for that object so tests can supply their own.
- **Introduce Instance Delegator** — *Static methods block you.* Add an instance method
  that delegates to the static; depend on the instance method, which you can override.

## Globals, statics, and singletons

- **Encapsulate Global References** — *Globals used directly throughout.* Wrap the
  globals in a class and reference them through an instance you can replace under test.
- **Replace Global Reference with Getter** — *A global reference inside a class.* Route
  it through a getter method you can override in a testing subclass.
- **Introduce Static Setter** — *A singleton you can't replace.* Add a static setter (or
  protected constructor) so a test can install a fake instance.
- **Expose Static Method** — *Logic trapped in an untestable class, but it uses no
  instance state.* Make it a static method you can test without instantiating the class.
- **Break Out Method Object** — *A huge method with too many locals to test.* Move it to
  a new class whose fields are the old locals; now you can instantiate and test it in
  isolation.

## Awkward parameters and data

- **Adapt Parameter** — *A method takes a parameter you can't construct/fake in a test*
  (e.g. a framework type). Introduce a narrow interface you *can* fake, and adapt it to
  the real parameter — when you can't Extract Interface on the parameter's own class.
- **Primitivize Parameter** — *Passing a whole hard-to-build object just for a little
  data.* Pass the primitive data it needs instead (a conservative first cut; heal later).

## Moving members to enable testing

- **Pull Up Feature** — *Dependencies you don't care about block instantiation.* Pull the
  feature you want to test up into an abstract superclass and test it via a concrete
  testing subclass that skips the bad dependencies.
- **Push Down Dependency** — *A problematic dependency is tangled into a class.* Push it
  down into a new subclass, leaving the rest of the class abstract and testable.
- **Supersede Instance Variable** — *A field is set to an awkward object in the
  constructor.* Add a setter (used only in test) to supersede it after construction —
  when Subclass and Override isn't available.

## Procedural / language-specific seams

- **Link Substitution** — *C/C++ (or any linked language): a free function or library
  call blocks you.* Provide a stub with the same signature and link it instead (link
  seam; enabling point is the build).
- **Definition Completion** — *C/C++: a type/function is declared but you control the
  definition.* Provide a test definition in the test build.
- **Replace Function with Function Pointer** — *C: swap a function call for a call
  through a pointer* you can repoint at a stub under test.
- **Template Redefinition** — *C++: use template parameters* to substitute a testing
  type for a production one.
- **Text Redefinition** — *Interpreted languages (e.g. Ruby): redefine a method's text*
  at test time to replace its behavior.

---

*Source: Michael Feathers, "Working Effectively with Legacy Code" (Prentice Hall,
2004), Chapter 25 — Dependency-Breaking Techniques.*
